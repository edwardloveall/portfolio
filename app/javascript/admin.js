import Rails from "@rails/ujs";

Rails.start();
require("@rails/activestorage").start();

import "../assets/javascripts/draggable";

// Stimulus
import { Application } from "@hotwired/stimulus";

import DragItemsController from "./controllers/drag_items_controller";
import SortItemsController from "./controllers/sort_items_controller";

window.Stimulus = Application.start();
Stimulus.register("drag-items", DragItemsController);
Stimulus.register("sort-items", SortItemsController);
