import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "check" ]

  toggle() {
    this.inputTarget.checked = !this.inputTarget.checked
    this.checkTarget.classList.toggle("hidden")
    this.element.classList.toggle("border-l-blue-500")
  }
} 