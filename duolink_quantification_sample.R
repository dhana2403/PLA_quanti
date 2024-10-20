library(EBImage)
library(imager)

image_path <- "./data/image/raw/sample.jpg"
img <- readImage(image_path)

red_channel <- img[,,1]

threshold_value <- 0.6  # Adjust this based on the intensity in the red channel

binary_img <- red_channel > threshold_value  

# Convert to cimg format for dilating using imager
binary_img_cimg <- as.cimg(as.numeric(binary_img), dim = c(dim(binary_img), 1))

# Perform dilation using imager
binary_img_dilated <- imager::dilate_square(binary_img_cimg, size = 3)  

#Convert back to binary Image object for further EBImage processing
binary_img_dilated <- Image(matrix(binary_img_dilated, nrow = dim(binary_img)[1], ncol = dim(binary_img)[2]))  # Reformat to 2D

# Label PLA signals
labels <- bwlabel(binary_img_dilated)

#Compute features of the detected regions (e.g., area, perimeter)
regions <- computeFeatures.shape(labels)
print(regions)

#Count the number of PLA signals
num_signals <- max(labels, na.rm = TRUE)
print(paste("Number of PLA signals detected:", num_signals))

#Create result directory and save the images
output_dir <- "./data/image/results/"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)  
writeImage(binary_img, file.path(output_dir, "binary_img.png"))
