import React from "react";
import {
  useCurrentFrame,
  useVideoConfig,
  interpolate,
  Easing,
} from "remotion";

const SITE_URL =
  "https://owencorpening.github.io/widgets/planetary-aquifer-registry.html";

const IFRAME_W = 1440;
const IFRAME_H = 900;

const EASE = {
  easing: Easing.bezier(0.45, 0, 0.55, 1),
  extrapolateLeft: "clamp" as const,
  extrapolateRight: "clamp" as const,
};

export const PlanetaryFlyover: React.FC = () => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  // Phase 1 (0–1.5s):   quick zoom 1.8 → 3.5, header anchored near canvas top
  // Phase 2 (1.5–20s):  slow pan left → right across all columns
  // Phase 3 (20–23s):   scroll down to bottom rows (severe entries)
  // Phase 4 (23–41.5s): pan right → left back across bottom rows (same speed as phase 2)
  // Phase 5 (41.5–42s): hold at left for 0.5s
  const ZOOM_END   = Math.round(1.5 * fps); //   45
  const PAN_END    = 20  * fps;             //  600
  const SCROLL_END = 23  * fps;             //  690
  const PAN2_END   = PAN_END + (PAN_END - ZOOM_END); // 1155 — same duration as pan 1

  const zoomProgress   = interpolate(frame, [0,          ZOOM_END],   [0, 1], EASE);
  const panProgress    = interpolate(frame, [ZOOM_END,   PAN_END],    [0, 1], EASE);
  const scrollProgress = interpolate(frame, [PAN_END,    SCROLL_END], [0, 1], EASE);
  const pan2Progress   = interpolate(frame, [SCROLL_END, PAN2_END],   [0, 1], EASE);

  // Scale: 1.8 → 3.5, hold for all remaining phases
  const scale = interpolate(zoomProgress, [0, 1], [1.8, 3.5]);

  // X: zoom → left edge (+1561); pan1 sweeps to right edge (−3122 delta);
  //    scroll holds at right; pan2 sweeps back to left (+3122 delta)
  const translateX =
    interpolate(zoomProgress,  [0, 1], [0,    1561]) +
    interpolate(panProgress,   [0, 1], [0,   -3122]) +
    interpolate(pan2Progress,  [0, 1], [0,    3122]);

  // Y: zoom brings table top into view (12→505);
  //    scroll down adds −1405 → net −900, showing iframe y≈553–861 (bottom rows)
  const translateY =
    interpolate(zoomProgress,   [0, 1], [12,   505]) +
    interpolate(scrollProgress, [0, 1], [0,  -1405]);

  return (
    <div
      style={{
        width: "100%",
        height: "100%",
        backgroundColor: "#07071a",
        overflow: "hidden",
        position: "relative",
      }}
    >
      <div
        style={{
          position: "absolute",
          top: "50%",
          left: "50%",
          width: IFRAME_W,
          height: IFRAME_H,
          transformOrigin: "center center",
          transform: `translate(-50%, -50%) translate(${translateX}px, ${translateY}px) scale(${scale})`,
        }}
      >
        <iframe
          src={SITE_URL}
          style={{
            width: IFRAME_W,
            height: IFRAME_H,
            border: "none",
            display: "block",
            pointerEvents: "none",
          }}
        />
      </div>
    </div>
  );
};
