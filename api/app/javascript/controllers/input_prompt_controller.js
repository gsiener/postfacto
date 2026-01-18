import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["prompt", "input"]
  static values = { inputBg: { type: String, default: '#e0f2f1' } }

  focus() {
    if (this.hasPromptTarget) this.promptTarget.style.display = 'none'
    if (this.hasInputTarget) {
      this.inputTarget.style.backgroundColor = 'white'
      this.inputTarget.style.minHeight = '80px'
    }
  }

  blur() {
    if (this.hasInputTarget && !this.inputTarget.value.trim()) {
      if (this.hasPromptTarget) this.promptTarget.style.display = 'block'
      this.inputTarget.style.minHeight = '44px'
      this.inputTarget.style.backgroundColor = this.inputBgValue
    }
  }
}
