const Blink = require('node-blink-security');

var blink = new Blink('', '');
blink.setupSystem()
  .then(() => {
    blink.setArmed()
      .then(() => {
        // see the object dump for details
        console.log(blink);
      });
  }, (error) => {
    console.log(error);
  });
