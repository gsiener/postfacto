#
# Postfacto, a free, open-source and self-hosted retro tool aimed at helping
# remote teams.
#
# Copyright (C) 2016 - Present Pivotal Software, Inc.
#
# This program is free software: you can redistribute it and/or modify
#
# it under the terms of the GNU Affero General Public License as
#
# published by the Free Software Foundation, either version 3 of the
#
# License, or (at your option) any later version.
#
#
#
# This program is distributed in the hope that it will be useful,
#
# but WITHOUT ANY WARRANTY; without even the implied warranty of
#
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#
# GNU Affero General Public License for more details.
#
#
#
# You should have received a copy of the GNU Affero General Public License
#
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# Visual Styling Specification
# ============================
# This spec verifies the visual styling and layout of the retro board.
# These tests serve as a contract for frontend migrations (React -> Hotwire).
#
# Expected Colors (from _palette.scss):
#   Happy: #51c0b1 (teal)
#   Meh:   #fec722 (yellow)
#   Sad:   #e34e40 (red)
#   Action: #f2eee2 (light brown)
#   Page heading: #4BC1B1 (teal)

require 'spec_helper'

describe 'Visual Styling', type: :feature, js: true do
  before(:all) do
    register('visual-styling-test-user')
  end

  before(:each) do
    login('visual-styling-test-user')
  end

  describe 'Retro Board Layout' do
    before do
      @retro_url = create_public_retro('Visual Test Retro')
      visit @retro_url
    end

    specify 'displays three category columns' do
      expect(page).to have_css('.column-happy')
      expect(page).to have_css('.column-meh')
      expect(page).to have_css('.column-sad')
    end

    specify 'displays action items section' do
      expect(page).to have_css('.retro-action-header')
      expect(page).to have_field('Add an action item')
    end

    specify 'displays retro header with name' do
      expect(page).to have_css('.retro-name', text: 'Visual Test Retro')
    end

    specify 'displays retro menu button' do
      expect(page).to have_css('.retro-menu button')
    end

    specify 'happy column has correct input placeholder' do
      within('.column-happy') do
        expect(page).to have_css("textarea[placeholder=\"I'm glad that...\"]")
      end
    end

    specify 'meh column has correct input placeholder' do
      within('.column-meh') do
        expect(page).to have_css("textarea[placeholder=\"I'm wondering about...\"]")
      end
    end

    specify 'sad column has correct input placeholder' do
      within('.column-sad') do
        expect(page).to have_css("textarea[placeholder=\"It wasn't so great that...\"]")
      end
    end
  end

  describe 'Item Card Styling' do
    before do
      @retro_url = create_public_retro('Item Styling Test')
      visit @retro_url

      # Add items to each column
      fill_in("I'm glad that...", with: 'happy test item')
      find('.column-happy textarea.retro-item-add-input').native.send_keys(:return)

      fill_in("I'm wondering about...", with: 'meh test item')
      find('.column-meh textarea.retro-item-add-input').native.send_keys(:return)

      fill_in("It wasn't so great that...", with: 'sad test item')
      find('.column-sad textarea.retro-item-add-input').native.send_keys(:return)

      sleep 0.5 # Allow items to render
    end

    specify 'items display vote button' do
      within('div.retro-item', text: 'happy test item') do
        expect(page).to have_css('.item-vote-submit')
      end
    end

    specify 'items display edit button' do
      within('div.retro-item', text: 'happy test item') do
        expect(page).to have_css('.item-edit')
      end
    end

    specify 'voted items display vote count' do
      within('div.retro-item', text: 'happy test item') do
        find('.item-vote-submit').click
        expect(page).to have_content('1')
      end
    end
  end

  describe 'Highlight/Discussion Mode' do
    before do
      @retro_url = create_public_retro('Highlight Test')
      visit @retro_url

      fill_in("I'm glad that...", with: 'item to highlight')
      find('.column-happy textarea.retro-item-add-input').native.send_keys(:return)
      sleep 0.5
    end

    specify 'highlighted item shows in highlight section' do
      find('div.retro-item', text: 'item to highlight').click

      expect(page).to have_css('.highlight')
      expect(page).to have_css('.highlight .item-text', text: 'item to highlight')
    end

    specify 'highlighted item shows timer' do
      find('div.retro-item', text: 'item to highlight').click

      expect(page).to have_css('.retro-item-timer')
      expect(page).to have_css('.retro-item-timer-clock')
    end

    specify 'highlighted item shows done button' do
      find('div.retro-item', text: 'item to highlight').click

      within('.highlight') do
        expect(page).to have_css('.item-done')
      end
    end

    specify 'highlighted item shows cancel button' do
      find('div.retro-item', text: 'item to highlight').click

      within('.highlight') do
        expect(page).to have_css('.retro-item-cancel')
      end
    end

    specify 'done item shows discussed styling' do
      find('div.retro-item', text: 'item to highlight').click

      within('div.retro-item.highlight', text: 'item to highlight') do
        find('.item-done').click
      end

      expect(page).to have_css('.retro-item.discussed', text: 'item to highlight')
    end
  end

  describe 'Action Items' do
    before do
      @retro_url = create_public_retro('Action Items Test')
      visit @retro_url

      fill_in('Add an action item', with: 'test action item')
      find('.retro-action-header .retro-item-add-input').native.send_keys(:return)
      sleep 0.5
    end

    specify 'action item displays in action section' do
      expect(page).to have_css('.retro-action', text: 'test action item')
    end

    specify 'action item has checkbox' do
      within('.retro-action', text: 'test action item') do
        expect(page).to have_css('.action-tick')
      end
    end

    specify 'action item has edit button' do
      within('.retro-action', text: 'test action item') do
        expect(page).to have_css('.action-edit')
      end
    end

    specify 'completed action shows checked state' do
      within('.retro-action', text: 'test action item') do
        find('.action-tick img').click
        expect(page).to have_css('.action-tick-checked')
      end
    end
  end

  describe 'Settings Page' do
    before do
      @retro_url = create_public_retro('Settings Test')
      visit @retro_url
      click_menu_item 'Retro settings'
    end

    specify 'shows retro name field' do
      expect(page).to have_field('name', with: 'Settings Test')
    end

    specify 'shows retro URL field' do
      expect(page).to have_field('retro_url')
    end

    specify 'shows video link field' do
      expect(page).to have_field('video_link')
    end

    specify 'shows change password link' do
      expect(page).to have_link('Change password')
    end

    specify 'shows save button' do
      expect(page).to have_button('Save changes')
    end
  end

  describe 'Archives Page' do
    before do
      @retro_url = create_public_retro('Archive Test')
      visit @retro_url

      # Create an item and archive
      fill_in("I'm glad that...", with: 'archived item')
      find('.column-happy textarea.retro-item-add-input').native.send_keys(:return)

      click_menu_item 'Archive this retro'
      click_button 'Archive & send email'

      click_menu_item 'View archives'
    end

    specify 'shows archives list' do
      expect(page).to have_content('Archives')
      expect(page).to have_css('.archive-link')
    end

    specify 'archive shows archived items' do
      first('.archive-link a').click

      expect(page).to have_content('archived item')
    end

    specify 'archived items are read-only' do
      first('.archive-link a').click

      expect(page).not_to have_css('.item-edit')
      expect(page).not_to have_css('.item-vote-submit')
    end
  end
end
