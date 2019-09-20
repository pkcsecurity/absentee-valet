const Blink = require('node-blink-security');
const _ = require('lodash');

const blink = new Blink(process.env.BLINK_USERNAME, process.env.BLINK_PASSWORD);

const returnImageThumbnails = async () => {
  try {
    await blink.setupSystem();
    const cameras = await blink.getCameras();
    const arrayOfImageThumbs = await Promise.all(
      _(cameras).map(async camera => {
        console.log(camera.name);
        const imageData = await camera.fetchImageData();
        return imageData;
      })
    );
    console.log(arrayOfImageThumbs);
    return arrayOfImageThumbs;
  } catch (err) {
    console.log('camerasErr', err);
    return [];
  }
};

//export default returnImageThumbnails;

console.log(returnImageThumbnails());

