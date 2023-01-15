# Scale down the size of image files

Sometimes when you have lots of large image files it can be nice to be able to quickly scale down their size. This script lets you do that.

There is a flag `-size +50k` that decides the minimum size of images to scale. All images with a size under that value will be ignored. You could change the value if you would like larger images.

You can run the script several times until you think the images have been scaled down enough.

## How to run it

Be aware that the files will be converted in place. Before running the script, you may want to make a backup in order to preserve the original files.

Make the script executable.

`chmod +x scale-down-images.sh`

Then run the script.

`./scale-down-images.sh`

You will be asked for the path to the directory in which to scale images. If you entered a valid directory you will be asked to confirm. Then the processing will begin and the progress will be displayed.

