
library(EBImage)

image_path <- "./image/duolink.jpg"
img <- readImage(image_path)

red_channel <- channel(img, "red")

threshold <- 0.5  # Adjust this threshold if needed based on your image
binary_img <- red_channel > threshold

display(binary_img, title = "Binary Image (Red Channel)")


binary_img <- dilate(binary_img, makeBrush(3, shape = "disc"))
binary_img <- erode(binary_img, makeBrush(3, shape = "disc"))

labels <- bwlabel(binary_img)

regions <- computeFeatures.shape(labels)

print("Region properties:")
print(regions)

num_signals <- max(labels, na.rm = TRUE)
print(paste("Number of PLA signals detected:", num_signals))

color_labels <- colorLabels(labels)
display(color_labels, title = "Labeled Image (Red Channel PLA Signals)")

display(red_channel, title = "Red Channel Image")
