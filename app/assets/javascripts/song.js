var Song = function(options) {
  if (options.audio.nodeName == 'AUDIO') {
    this.audio = options.audio;
  } else {
    console.warn('audio passed to Song must be an <audio> element');
    return
  }

  this.button = options.button;
  this.track = options.track;
  this.progress = options.progress;
  this.remaining = options.remaining;
  this.length = options.length;

  this.button.addEventListener('click', function() {
    this.toggle();
  }.bind(this));

  this.track.addEventListener('click', function(click) {
    this.seek(click);
  }.bind(this));

  this.audio.addEventListener('timeupdate', function() {
    this.setProgress();
  }.bind(this));

  this.audio.addEventListener('loadeddata', function() {
    this.setProgress();
  }.bind(this));

  this.audio.addEventListener('ended', function() {
    this.endProgress();
  }.bind(this));

  this.play = function() {
    this.audio.play();
    this.button.classList.add('playing');
    this.button.classList.remove('paused');
  }

  this.pause = function() {
    this.audio.pause();
    this.button.classList.add('paused');
    this.button.classList.remove('playing');
  }

  this.toggle = function() {
    if (this.audio.paused) {
      this.play();
    } else {
      this.pause();
    }
  }

  this.seek = function(click) {
    var clickPosition = click.offsetX;
    var width = this.track.clientWidth;
    var percent = clickPosition / width;
    var length = this.audio.duration;
    var seconds = length * percent;
    this.audio.currentTime = seconds;
  }

  this.timeLeft = function() {
    var length = this.audio.duration;
    var remaining = this.audio.currentTime;
    var seconds = length - remaining;
    var percent = (remaining / length) * 100;
    return { seconds: seconds, percent: percent }
  }

  this.setProgress = function() {
    var timeLeft = this.timeLeft();
    var timeString = this.secondsToTimeString(timeLeft.seconds)
    this.progress.style.width = timeLeft.percent + '%';
    this.remaining.textContent = timeString;
  }

  this.endProgress = function() {
    this.audio.currentTime = 0;
    this.pause();
    this.setProgress();
  }

  this.secondsToTimeString = function(secondsNumber) {
    var minutes = Math.max(Math.floor(secondsNumber / 60), 0);
    var seconds = Math.max(Math.floor(secondsNumber % 60), 0)

    if (seconds <= 9) {
      seconds = '0' + seconds;
    }

    return minutes + ':' + seconds;
  }
}

$(function() {
  var songs = document.querySelectorAll('section.song');
  
  for (var i = 0; i < songs.length; i++) {
    new Song({
      audio: songs[i].querySelector('audio'),
      button: songs[i].querySelector('.button'),
      track: songs[i].querySelector('.track'),
      progress: songs[i].querySelector('.progress'),
      remaining: songs[i].querySelector('.remaining'),
    });
  }
})
