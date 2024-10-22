import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "toggle"]

  toggle() {
    this.sidebarTarget.classList.toggle('collapsed');

    if (this.sidebarTarget.classList.contains('collapsed')) {
      this.toggleTarget.classList.remove('fa-minus');
      this.toggleTarget.classList.add('fa-plus');
    } else {
      this.toggleTarget.classList.remove('fa-plus');
      this.toggleTarget.classList.add('fa-minus');
    }
  }
}
