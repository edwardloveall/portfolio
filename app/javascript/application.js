import "../assets/javascripts/detector";
import "../assets/javascripts/scrollDown";
import "../assets/javascripts/song";

import { Application } from "@hotwired/stimulus";

import HelloController from "./controllers/hello_controller";

window.Stimulus = Application.start();
Stimulus.register("hello", HelloController);
