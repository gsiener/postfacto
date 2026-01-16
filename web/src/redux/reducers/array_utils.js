/*
 * Postfacto, a free, open-source and self-hosted retro tool aimed at helping
 * remote teams.
 *
 * Copyright (C) 2016 - Present Pivotal Software, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 *
 * it under the terms of the GNU Affero General Public License as
 *
 * published by the Free Software Foundation, either version 3 of the
 *
 * License, or (at your option) any later version.
 *
 *
 *
 * This program is distributed in the hope that it will be useful,
 *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *
 * GNU Affero General Public License for more details.
 *
 *
 *
 * You should have received a copy of the GNU Affero General Public License
 *
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

/**
 * Updates an existing item in an array or adds it if not found.
 * Returns a new array (does not mutate the original).
 *
 * @param {Array} array - The array to update
 * @param {Object} item - The item to update or add
 * @param {string} idKey - The key to use for identifying items (default: 'id')
 * @returns {Array} A new array with the item updated or added
 */
const updateOrCreateInArray = (array, item, idKey = 'id') => {
  const position = array.findIndex((i) => i[idKey] === item[idKey]);

  if (position === -1) {
    return [...array, item];
  }

  const updatedArray = [...array];
  updatedArray[position] = item;
  return updatedArray;
};

export default updateOrCreateInArray;
