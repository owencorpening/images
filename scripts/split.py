#!/usr/bin/env python3
import os
from pydub import AudioSegment, silence
import argparse

def split_concert(input_file, output_dir=None, min_silence_len=2500, silence_thresh=-40, keep_silence=500):
    """
    Splits a long concert recording into separate MP3s per song based on silence.
    """
    if not output_dir:
        output_dir = os.path.splitext(input_file)[0] + "_songs"
    os.makedirs(output_dir, exist_ok=True)

    print(f"Loading {input_file} ...")
    audio = AudioSegment.from_file(input_file, format="mp3")

    print("Detecting silences...")
    silences = silence.detect_nonsilent(audio, min_silence_len=min_silence_len, silence_thresh=silence_thresh)

    print(f"Found {len(silences)} segments.")
    for i, (start, end) in enumerate(silences, 1):
        chunk = audio[start:end]
        out_file = os.path.join(output_dir, f"song_{i:02d}.mp3")
        chunk.export(out_file, format="mp3", bitrate="192k")
        print(f"Saved: {out_file} ({(end-start)/1000:.1f}s)")

    print("Done!")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Split long concert MP3s into separate songs.")
    parser.add_argument("input_file", help="Path to concert MP3")
    parser.add_argument("--output-dir", help="Directory for output songs")
    parser.add_argument("--min-silence-len", type=int, default=2500, help="Minimum silence length (ms)")
    parser.add_argument("--silence-thresh", type=int, default=-40, help="Silence threshold (dBFS)")
    parser.add_argument("--keep-silence", type=int, default=500, help="Silence padding on each side (ms)")
    args = parser.parse_args()

    split_concert(args.input_file, args.output_dir, args.min_silence_len, args.silence_thresh, args.keep_silence)
