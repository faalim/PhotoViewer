# PhotoViewer

## Description

This project is a simple photo viewer app in Swift. It allows you to select and view images from a collection of your favorite photos. 
The app includes features such as image selection using a picker view, image navigation through swipe gestures, and network activity indicator handling.

## How to Use

1. Visit an image site like [https://www.freeimages.com/](https://www.freeimages.com/).
2. Copy the link address of your favorite photos.
3. Create a model class with a lazy property that holds the information of your favorite images in the format of a dictionary, where the key is the name and the value is the URL.
   
   Example:
   ```swift
   lazy var listOfImages = [
       "Sunset": "https://images.freeimages.com/images/large-previews/1c9/maine-at-4-45-am-1370871.jpg"
   ]
   ```

4. This app has a picker view listing all the items from the model object.
5. When a user selects a row in the picker view, the image should be displayed in the image view.
6. This app has gestures to the image view using `UISwipeGestureRecognizer`:
   - A right swipe will show the previous image.
   - A left swipe will show the next image.
   - The picker view will also automatically change with the swipe.

## Additional Features

- An activity indicator starts animating at the beginning of a network request and stops when the request is completed.

You can find the code in the provided Swift files:

- `PhotoInfo.swift`: Contains the model class with a dictionary of photos and their URLs.
- `Service.swift`: Provides network service to fetch images.
- `ViewController.swift`: Implements the main view controller with features for image selection, swipe gestures, and network activity indicator.

<img width="219" alt="PhotoView" src="https://github.com/faalim/PhotoViewer/assets/109769086/e19d3a1d-b66f-41d5-89e2-34bd3c7dfd4b">

