#! /bin/bash

echo "Building project"
echo

echo "Creating build directories"
echo "---------------------------"
mkdir -v build && mkdir -v build/css && mkdir -v build/img && mkdir -v build/js && mkdir -v build/fonts
echo

echo "Minifying HTML files"
echo "------------------------"
for file in *
	do
		if [[ $file == *.html ]]
			then
				echo "html-minifier --html5 --remove-comments --collapse-whitespace -o build/$file -> $file"

				html-minifier --html5 --remove-comments --collapse-whitespace -o build/$file $file
		fi
	done

echo

echo "Minifying CSS files"
echo "--------------------"
for file in css/*
	do
		if [[ ! $file == *.min.css ]]
			then
				echo "cleancss $file -> build/$file"
				cleancss --inline all -o build/$file $file
		fi
	done

echo

echo "Minifying JS files"
echo "-------------------"
for file in js/*
	do
		if [[ ! $file == *.min.js ]]
			then
				echo "uglifyjs --screw-ie8  --compress --mangle --verbose --output build/$file -> $file"
				uglifyjs --screw-ie8  --compress --mangle --verbose --output build/$file -- $file
		fi
	done

echo

echo "Copying images"
echo "---------------"
for file in img/*
	do
		if [[ $file =~ .*\.(jpg|jpeg|gif|png|webp|ico) ]]
			then
				cp -v $file build/$file
		fi
	done

echo

echo "Copying fonts"
echo "--------------"
for file in fonts/*
	do
		if [[ $file == *.woff2 ]]
			then
				cp -v $file build/$file
		fi
	done

echo

echo "Copying sitemap"
echo "--------------"
cp -v sitemap.xml build/sitemap.xml

echo

echo "Copying robots.txt"
echo "--------------"
cp -v robots.txt build/robots.txt

echo
echo "Finished building project"
