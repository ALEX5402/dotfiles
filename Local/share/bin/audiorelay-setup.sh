#!/usr/bin/env bash

# # the virtual audio device
# pactl load-module module-null-sink \
# 	sink_name=audiorelay-speakers \
# 	sink_properties=device.description=AudioRelay-Speakers


	# set the sink device
pactl load-module module-null-sink \
	sink_name=audiorelay-virtual-mic-sink \
	sink_properties=device.description=Virtual-Mic-Sink

	# create the mic
pactl load-module module-remap-source \
	master=audiorelay-virtual-mic-sink.monitor \
	source_name=audiorelay-virtual-mic-sink \
	source_properties=device.description=Virtual-Mic

audiorelay --minimized
