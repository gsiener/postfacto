import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display"]
  static values = {
    seconds: { type: Number, default: 300 },
    running: { type: Boolean, default: true }
  }

  connect() {
    this.remaining = this.secondsValue
    if (this.runningValue) this.start()
  }

  disconnect() {
    this.stop()
  }

  start() {
    this.interval = setInterval(() => this.tick(), 1000)
  }

  stop() {
    if (this.interval) clearInterval(this.interval)
  }

  tick() {
    if (this.remaining > 0) {
      this.remaining--
      this.updateDisplay()
    } else {
      this.stop()
    }
  }

  updateDisplay() {
    const mins = Math.floor(this.remaining / 60)
    const secs = this.remaining % 60
    if (this.hasDisplayTarget) {
      this.displayTarget.textContent = `${mins}:${secs.toString().padStart(2, '0')}`
    }
  }
}
