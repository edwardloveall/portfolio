import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static classes = ["preview"];

  connect() {
    this.dragPreview = null;
    this.dropSide = "afterend";
    this.dropTarget = null;
  }

  dragstart(event) {
    this.removeDragImage(event);
    this.registerDraggedItem(event);
    this.dragPreview = this.createDragPreview(event);
    event.currentTarget.insertAdjacentElement("afterend", this.dragPreview);
    event.currentTarget.classList.add("dragging");
  }

  dragenter(event) {
    event.preventDefault();
    this.dropTarget = event.currentTarget;
  }

  dragover(event) {
    event.preventDefault();
    if (!this.isDragSibling(event)) {
      return;
    }

    this.dropSide = this.calcuateDropSide(event);
    this.dropTarget.insertAdjacentElement(this.dropSide, this.dragPreview);
  }

  drop(event) {
    const draggedElement = this.draggedItem(event);
    this.dropTarget.insertAdjacentElement(this.dropSide, draggedElement);
  }

  dragend(event) {
    this.dragPreview.remove();
    const draggedElement = this.draggedItem(event);
    draggedElement.classList.remove("dragging");
    if (this.successfulDrag(event)) {
      this.dispatch("success");
    }
  }

  removeDragImage(event) {
    event.dataTransfer.setDragImage(new Image(), 0, 0);
  }

  registerDraggedItem(event) {
    event.dataTransfer.setData(
      "application/drag-key",
      event.currentTarget.getAttribute("data-drag-items-id")
    );
    event.dataTransfer.effectAllowed = "move";
  }

  createDragPreview(event) {
    const dragPreview = event.currentTarget.cloneNode();
    dragPreview.classList.add(this.previewClass);
    dragPreview.attributes.removeNamedItem("draggable");
    dragPreview.attributes.removeNamedItem("data-drag-items-id");
    return dragPreview;
  }

  calcuateDropSide(event) {
    const mouseY = event.clientY;
    const dropTargetDimensions = this.dropTarget.getBoundingClientRect();
    const dropTargetMiddle =
      dropTargetDimensions.top + dropTargetDimensions.height / 2;

    if (mouseY > dropTargetMiddle) {
      return "afterend";
    } else {
      return "beforebegin";
    }
  }

  isDragSibling(event) {
    return event.currentTarget.hasAttribute("data-drag-items-id");
  }

  draggedItem(event) {
    const data = event.dataTransfer.getData("application/drag-key");
    return this.element.querySelector(`[data-drag-items-id='${data}']`);
  }

  successfulDrag(event) {
    return event.dataTransfer.dropEffect === "move";
  }
}

// POST /admin/projects/sort
//   project[]=1&project[]=2&project[]=3
//   AKA: { project: [1, 2, 3] }
