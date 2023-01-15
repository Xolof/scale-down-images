# Script for scaling down the size of image files

Sometimes when you have lots of large image files it can be nice to be able to quickly scale down their size. This script lets you do that.

There is a flag `-size +50k` that decides the minimum size of images to scale. All images with a size under that value will be ignored. You could change the value if you would like larger images.

You can run the script several times until you think the images have been scaled down enough.

## How to run it

First make the script executable.

`chmod +x scale-down-images.sh`

Then run it.

`./scale-down-images.sh`

