const AWS = require('aws-dek');

const _ = require('lodash');

const credentials = new AWS.SharedIniFileCredentials({ profile: 'default' });
AWS.config.credentials = credentials;
AWS.config.update({ region: 'us-east-1' });
const rekog = new AWS.Rekognition();

module.exports.getCarCount = async (picture) => {
  const params = {
    Image: { Bytes: picture },
  };

  const res = await rekog.detectLabels(params).promise();

  const count = _.chain(res.Labels)
    .find((val) => val.Name === 'Car')
    .get('Instances.length')
    .value();

  return count;
};
