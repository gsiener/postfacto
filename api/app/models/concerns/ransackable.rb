# frozen_string_literal: true

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

# Provides a DSL for configuring Ransack searchable attributes and associations.
#
# Usage:
#   class MyModel < ApplicationRecord
#     include Ransackable
#
#     ransackable attributes: %w[id name created_at],
#                 associations: %w[items users]
#   end
#
module Ransackable
  extend ActiveSupport::Concern

  class_methods do
    def ransackable(attributes: [], associations: [])
      @ransackable_attrs = attributes.map(&:to_s)
      @ransackable_assocs = associations.map(&:to_s)
    end

    def ransackable_attributes(_auth_object = nil)
      @ransackable_attrs || []
    end

    def ransackable_associations(_auth_object = nil)
      @ransackable_assocs || []
    end
  end
end
