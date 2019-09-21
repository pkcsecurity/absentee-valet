const Blink = require('node-blink-security');
const _ = require('lodash');
const fs = require('fs');

const blink = new Blink(process.env.BLINK_USERNAME, process.env.BLINK_PASSWORD);

module.exports.returnImageThumbnails = async () => {
  try {
    await blink.setupSystem();
    const arrayOfImageThumbs = await Promise.all(
      _(blink.cameras)
        .filter((camera) => _.includes(['West Side Parking', 'Absentee Valet', 'B Lane Parking'], camera.name))
        .map(async (camera) => {
          console.log(camera.name);
          console.log(camera.motion);
          console.log(camera.updated_at);
          await camera.snapPicture();
          await camera.imageRefresh();
          const imageData = await camera.fetchImageData();
          const wstream = fs.createWriteStream(`${camera.name}.jpg`);
          wstream.write(imageData);
          wstream.end();
          return imageData;
        })
    );
    return arrayOfImageThumbs;
  } catch (err) {
    console.log('camerasErr', err);
    return [];
  }
};

//returnImageThumbnails();
