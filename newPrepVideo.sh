#!/bin/sh

rm -r ./outputVideos/

mkdir ./outputVideos/

ffmpeg -i ./sampleVideos/sample1440p.mp4 ./outputVideos/output1440.yuv

#kvazaar -i ./outputVideos/output1440.yuv --input-res 2732x1366 -o ./outputVideos/output_low.hvc --bitrate 256000 --qp 22 --tiles 3x3 --slices tiles --mv-constraint frametilemargin --period 32 --input-fps 30

kvazaar -i ./outputVideos/output1440.yuv --input-res 2732x1366 -o ./outputVideos/output_high.hvc --bitrate 64000 --qp 22 --tiles 3x3 --slices tiles --mv-constraint frametilemargin --period 32 --input-fps 30

#MP4Box -add ./outputVideos/output_low.hvc:split_tiles -fps 30 -new ./outputVideos/video_tiled_low.mp4
MP4Box -add ./outputVideos/output_high.hvc:split_tiles -fps 30 -new ./outputVideos/video_tiled_high.mp4

#gpac -i ./outputVideos/output_48k.hvc tilesplit:tiledrop=2 tileagg -o ./outputVideos/video_tiled_48k.mp4
#gpac -i ./outputVideos/output_256k.hvc tilesplit:tiledrop=5 tileagg -o ./outputVideos/video_tiled_256k.mp4


MP4Box -dash 1800 -profile live -out ./outputVideos/dash_tiled.mpd ./outputVideos/video_tiled_high.mp4 #./outputVideos/video_tiled_high.mp4

