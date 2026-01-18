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
module RetrosHelper
  # Groups action items by date into Today, Past Week, and Older categories.
  # Returns a hash with :grouped (the grouped items hash) and :group_order (array of labels in display order)
  def group_action_items_by_date(action_items)
    today = Date.today
    one_week_ago = today - 7
    today_label = "Today (#{today.strftime('%B %d, %Y')})"

    grouped = action_items.group_by do |item|
      item_date = item.created_at.to_date
      if item_date == today
        today_label
      elsif item_date > one_week_ago
        'Past Week'
      else
        'Older'
      end
    end

    group_order = [today_label, 'Past Week', 'Older']

    { grouped: grouped, group_order: group_order }
  end
end
