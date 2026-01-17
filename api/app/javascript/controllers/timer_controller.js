import { Controller } from "@hotwired/stimulus"

// Handles discussion countdown timer
export default class extends Controller {
  static targets = ["display", "extendButton"]
  static values = {
    endTime: Number,
    retroId: String
  }

  connect() {
    if (this.hasEndTimeValue && this.endTimeValue > 0) {
      this.startCountdown()
    }
  }

  disconnect() {
    this.stopCountdown()
  }

  startCountdown() {
    this.tick()
    this.intervalId = setInterval(() => this.tick(), 1000)
  }

  stopCountdown() {
    if (this.intervalId) {
      clearInterval(this.intervalId)
      this.intervalId = null
    }
  }

  tick() {
    const now = Date.now()
    const remaining = Math.max(0, this.endTimeValue - now)

    if (remaining <= 0) {
      this.stopCountdown()
      this.displayTarget.textContent = "0:00"
      this.displayTarget.classList.add("text-red-600", "animate-pulse")
      return
    }

    const minutes = Math.floor(remaining / 60000)
    const seconds = Math.floor((remaining % 60000) / 1000)
    this.displayTarget.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`

    // Add warning styles when time is running low
    if (remaining <= 30000) {
      this.displayTarget.classList.add("text-red-600")
    } else if (remaining <= 60000) {
      this.displayTarget.classList.add("text-yellow-600")
    }
  }

  endTimeValueChanged() {
    this.stopCountdown()
    if (this.endTimeValue > 0) {
      this.displayTarget.classList.remove("text-red-600", "text-yellow-600", "animate-pulse")
      this.startCountdown()
    }
  }
}
