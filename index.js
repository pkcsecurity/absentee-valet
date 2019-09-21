const _ = require('lodash');
const { returnImageThumbnails } = require('./blink');
const { getCarCount } = require('./rekognition');

module.exports.handler = async (event) => {
  const pictures = await returnImageThumbnails();
  const carCount = await Promise.all(_.map(pictures, async (p) => await getCarCount(p)));

  console.log(carCount);
  const response = {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: 'Go Serverless v1.0! Your function executed successfully!',
        carCount,
      },
      null,
      2
    ),
  };

  return response;

  // Use this code if you don't use the http event with the LAMBDA-PROXY integration
  // return { message: 'Go Serverless v1.0! Your function executed successfully!', event };
};
