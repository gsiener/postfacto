import { Controller } from "@hotwired/stimulus"

// Handles mobile tab switching between retro categories
export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = {
    activeTab: { type: String, default: "happy" }
  }

  connect() {
    this.showTab(this.activeTabValue)
  }

  switch(event) {
    event.preventDefault()
    const tab = event.currentTarget.dataset.tabsTab || event.params.tab
    this.activeTabValue = tab
    this.showTab(tab)
  }

  showTab(tab) {
    // Update tab styles
    this.tabTargets.forEach(tabElement => {
      const isActive = tabElement.dataset.tabsTab === tab
      tabElement.classList.toggle("border-b-2", isActive)
      tabElement.classList.toggle("border-blue-500", isActive)
      tabElement.classList.toggle("text-blue-600", isActive)
      tabElement.classList.toggle("text-gray-500", !isActive)
    })

    // Show/hide panels
    this.panelTargets.forEach(panel => {
      const isActive = panel.dataset.tabsPanel === tab
      panel.classList.toggle("hidden", !isActive)
    })
  }

  activeTabValueChanged() {
    this.showTab(this.activeTabValue)
  }
}
