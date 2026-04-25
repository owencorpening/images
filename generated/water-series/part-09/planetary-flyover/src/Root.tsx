import "./index.css";
import { Composition } from "remotion";
import { PlanetaryFlyover } from "./Composition";

export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="PlanetaryFlyover"
      component={PlanetaryFlyover}
      durationInFrames={1170}
      fps={30}
      width={1920}
      height={1080}
    />
  );
};
