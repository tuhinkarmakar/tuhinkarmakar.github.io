#! /bin/bash

mkdir -v build && mkdir -v build/css && mkdir -v build/img && mkdir -v build/js && mkdir -v build/fonts
echo

for file in *
	do
		if [[ $file == *.html ]]
			then
				echo html-minifier --html5 --remove-comments --collapse-whitespace -o build/$file $file

				html-minifier --html5 --remove-comments --collapse-whitespace -o build/$file $file
		fi
	done

echo

for file in css/*
	do
		if [[ $file == *.css ]]
			then
				echo cleancss $file build/css/$file
				cleancss -o build/$file $file
		fi
	done

echo

for file in js/*
	do
		if [[ $file == *.js ]]
			then
				echo uglifyjs --screw-ie8  --compress --mangle --verbose --output build/$file -- $file
				uglifyjs --screw-ie8  --compress --mangle --verbose --output build/$file -- $file
		fi
	done

echo

for file in img/*
	do
		if [[ $file =~ .*\.(jpg|jpeg|gif|png|webp|ico) ]]
			then
				cp -v $file build/$file
		fi
	done

echo

for file in fonts/*
	do
		if [[ $file == *.woff2 ]]
			then
				cp -v $file build/$file
		fi
	done
