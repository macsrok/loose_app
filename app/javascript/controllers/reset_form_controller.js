import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview"]

  connect() {
    this.adjustHeight()
  }

  adjustHeight(event) {
    const textarea = this.element.querySelector('textarea')
    textarea.style.height = "auto"
    textarea.style.height = (textarea.scrollHeight) + "px"
  }

  preview(event) {
    const file = event.target.files[0]
    if (file) {
      const reader = new FileReader()
      reader.onload = (e) => {
        this.previewTarget.src = e.target.result
        this.previewTarget.parentElement.classList.remove("hidden")
        this.adjustHeight()
      }
      reader.readAsDataURL(file)
    }
  }

  removeImage() {
    this.element.querySelector('input[type="file"]').value = ""
    this.previewTarget.src = ""
    this.previewTarget.parentElement.classList.add("hidden")
    this.adjustHeight()
  }

  reset() {
    this.element.reset()
    this.previewTarget.src = ""
    this.previewTarget.parentElement.classList.add("hidden")
    this.adjustHeight()
  }
} 