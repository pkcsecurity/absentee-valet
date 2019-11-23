const Blink = require('node-blink-security');
const _ = require('lodash');
const fs = require('fs');
const sharp = require('sharp');

const blink = new Blink(process.env.BLINK_USERNAME, process.env.BLINK_PASSWORD);

module.exports.returnImageThumbnails = async () => {
  try {
    await blink.setupSystem();
    const arrayOfImageThumbs = await Promise.all(
      _(blink.cameras)
        .filter((camera) => _.includes(['West Side Parking', 'Absentee Valet'], camera.name))
        .map(async (camera) => {
          console.log(camera.name);
          console.log(camera.motion);
          console.log(camera.updated_at);
          await camera.snapPicture();
          await camera.imageRefresh();
          const imageData = await camera.fetchImageData();

          /*
          const wstream = fs.createWriteStream(`${camera.name}.jpg`);
          wstream.write(imageData);
          wstream.end();
          */
          
          if(camera.name == 'West Side Parking') {
            console.log("editing west side parking picture");
            const result = await sharp(imageData)
              .composite([{
                top: 0,
                left: 0,
                input: 'westsideredout.png',
                blend: 'atop'
              }])
              .png()
              .toBuffer();
            return {"parking lot" : "Small Parking Lot", "picture": result};
          } else {
            const result = await sharp(imageData)
              .composite([{
                top: 0,
                left: 0,
                input: 'absenteevaletredouttopleft.png',
                blend: 'atop'
              },
              {
                top: 0,
                left: 0,
                input: 'absenteevaletredouttopright.png',
                blend: 'atop'
              }])
              .png()
              .toBuffer();
            return {"parking lot" : "Big Parking Lot", "picture": result};
          }
        })
    );
    return arrayOfImageThumbs;
  } catch (err) {
    console.log('camerasErr', err);
    return [];
  }
};

//returnImageThumbnails();
