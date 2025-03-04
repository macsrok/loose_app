import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "container" ]

  connect() {
    this.scrollToBottom()

    // Listen for broadcast actions
    this.element.addEventListener("messages:scrollToBottom", () => {
      this.scrollToBottom()
    })
  }

  disconnect() {
    // Clean up event listener
    this.element.removeEventListener("messages:scrollToBottom", () => {
      this.scrollToBottom()
    })
  }

  scrollToBottom() {
    // Use requestAnimationFrame to ensure DOM is updated before scrolling
    requestAnimationFrame(() => {
      this.containerTarget.scrollTop = this.containerTarget.scrollHeight
    })
  }
} 