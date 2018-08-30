#!/bin/bash 

nwarps=(1 2 4 8 16 32)
ngpu=(1 2 4 8)


for nv in `seq 20 30`
do
	for ng in "${ngpu[@]}"
	do
		for nw in "${nwarps[@]}"
		do 
			rm -rf bfs_romeo_hypercube.o 
			rm -rf romeo_hypercube
			# Recompile
			make INPUT="-DNWARPS=$nw -DNGPU=$ng"
			name="test_"$nv"_"$ng"_"$nw
			rm -rf $name
			echo "test: "$name
			./romeo_hypercube -s $nv &> $name
			# echo -e $output >> $name
		done
	done
done

