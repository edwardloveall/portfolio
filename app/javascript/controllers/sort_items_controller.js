import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    sortKey: String,
    url: String,
  };

  sort(event) {
    const ids = Array.from(
      this.element.querySelectorAll("[data-sort-items-id]")
    ).map((item) => item.getAttribute("data-sort-items-id"));
    this.sendRequest(ids);
  }

  sendRequest(ids) {
    const body = Object.fromEntries([[this.sortKeyValue, ids]]);
    fetch(this.urlValue, {
      method: "POST",
      headers: this.requestHeaders,
      body: JSON.stringify(body),
    });
  }

  get requestHeaders() {
    return new Headers({
      "Content-Type": "application/json",
      "X-CSRF-Token": this.csrfToken,
    });
  }

  get csrfToken() {
    return document.head.querySelector("[name=csrf-token]").content;
  }
}
