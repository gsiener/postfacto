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
module ApplicationHelper
  # Returns Tailwind background color class for retro item categories
  def category_bg_class(category)
    case category.to_s
    when 'happy'
      'bg-green-500'
    when 'meh'
      'bg-yellow-500'
    when 'sad'
      'bg-red-500'
    else
      'bg-gray-500'
    end
  end

  # Returns Tailwind border color class for retro item categories
  def category_border_class(category)
    case category.to_s
    when 'happy'
      'border-l-green-500'
    when 'meh'
      'border-l-yellow-500'
    when 'sad'
      'border-l-red-500'
    else
      'border-l-gray-500'
    end
  end

  # Returns Tailwind badge classes for retro item categories
  def category_badge_class(category)
    case category.to_s
    when 'happy'
      'bg-green-100 text-green-800'
    when 'meh'
      'bg-yellow-100 text-yellow-800'
    when 'sad'
      'bg-red-100 text-red-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end
end
