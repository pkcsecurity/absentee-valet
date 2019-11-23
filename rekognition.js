const AWS = require('aws-sdk');
const _ = require('lodash');

const rekog = new AWS.Rekognition({
  accessKeyId: process.env.ACCESS_KEY,
  secretAccessKey: process.env.SECRET_KEY,
  region: 'us-east-1',
});

module.exports.getCarCount = async (pictureMap) => {
  const params = {
    Image: { Bytes: pictureMap["picture"] },
  };

  const res = await rekog.detectLabels(params).promise();

  const count = _.chain(res.Labels)
    .find((val) => val.Name === 'Car')
    .get('Instances.length')
    .value();

  return count;
};
