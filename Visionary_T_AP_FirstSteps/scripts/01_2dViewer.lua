--[[----------------------------------------------------------------------------

  Application Name: 01_2dViewer

  Summary:
  Show the distance, intensity and confidence images in three separate views

  Description:
  Set up the camera to take live images continuously. React to the "OnNewImage"
  event and display the distance and intensity image, as well as the confidence
  map by selecting the right image from the table that is passed and show them
  on the correct view.

  How to run:
  First set this app as main (right-click -> "Set as main").
  Start by running the app (F5) or debugging (F7+F10).
  Set a breakpoint on the first row inside the main function to debug step-by-step.
  See the results in the different image viewer on the DevicePage.

  More Information:
  See the tutorial Visionary-T AP FirstSteps

------------------------------------------------------------------------------]]

-- Setup the camera
local camera = Image.Provider.Camera.create()
Image.Provider.Camera.stop(camera)

-- Setup the different views
local viewDistance = View.create('distanceViewer')
local viewIntensity = View.create('intensityViewer')
local viewConfidence = View.create('confidenceViewer')

--setup the pixel value range
local decoration = View.ImageDecoration.create()
View.ImageDecoration.setRange(decoration, 0, 10000)

local function main()
  Image.Provider.Camera.start(camera)
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

---@param image Image
---@param sensordata SensorData
local function handleOnNewImage(image)
  View.addImage(viewDistance, image[1], decoration) --distance image is first element of the image table
  View.addImage(viewIntensity, image[2], decoration) --intensity image is second element of the image table
  View.addImage(viewConfidence, image[3], decoration) --confidence map is third element of the image table

  --present the added images
  View.present(viewDistance)
  View.present(viewIntensity)
  View.present(viewConfidence)
end
Image.Provider.Camera.register(camera, 'OnNewImage', handleOnNewImage)
--End of Function and Event Scope-----------------------------------------------
