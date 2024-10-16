library(EBImage)

path <- "./image/duolink.jpg"

duo <- readImage(path)

red_channel <- channel(duo, "red")

threshold <- 0.5  # Adjust threshold as per your need

binary_img <- red_channel > threshold

display(binary_img, title = "Binary Image (Red Channel)")

binary_img <- dilate(binary_img, makeBrush(3, shape = "disc"))

binary_img <- erode(binary_img, makeBrush(3, shape = "disc"))

labels <- bwlabel(binary_img)

regions <- computeFeatures.shape(labels)

print(regions)

num_signals <- max(labels, na.rm = TRUE)

print(paste("Number of PLA signals detected:", num_signals))

color_labels <- colorLabels(labels)

display(color_labels, title = "Red Channel PLA Signals")

display(red_channel, title = "Red Channel")
