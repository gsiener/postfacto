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
class ActionItem < ActiveRecord::Base
  belongs_to :retro, optional: true
  belongs_to :archive, optional: true

  # Turbo Stream broadcasts for real-time updates
  after_create_commit -> { broadcast_append_to retro, target: "action-items", partial: "hotwire/action_items/action_item", locals: { action_item: self, retro: retro } }
  after_update_commit -> { broadcast_replace_to retro, partial: "hotwire/action_items/action_item", locals: { action_item: self, retro: retro } }
  after_destroy_commit -> { broadcast_remove_to retro }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id description done created_at updated_at archived_at archived retro_id archive_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[archive retro]
  end
end
