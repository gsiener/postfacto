import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "form", "input", "description"]
  static values = { editing: { type: Boolean, default: false } }

  edit(event) {
    if (event) event.preventDefault()
    this.editingValue = true
  }

  cancel(event) {
    if (event) event.preventDefault()
    this.editingValue = false
    if (this.hasInputTarget && this.hasDescriptionTarget) {
      this.inputTarget.value = this.descriptionTarget.textContent.trim()
    }
  }

  editingValueChanged() {
    if (this.hasDisplayTarget && this.hasFormTarget) {
      this.displayTarget.classList.toggle("hidden", this.editingValue)
      this.formTarget.classList.toggle("hidden", !this.editingValue)
      if (this.editingValue && this.hasInputTarget) {
        this.inputTarget.focus()
        this.inputTarget.select()
      }
    }
  }

  keydown(event) {
    if (event.key === "Escape") this.cancel()
  }
}
