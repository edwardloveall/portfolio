require("webpack-jquery-ui/sortable");
import Rails from "@rails/ujs";

Rails.start();
require("@rails/activestorage").start();

import "javascripts/draggable";

// stylesheets
import "stylesheets/admin/admin";
