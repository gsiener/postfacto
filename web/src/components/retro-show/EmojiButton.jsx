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

import React from 'react';
import * as PropTypes from 'prop-types';

/**
 * Individual emoji button component
 * Renders a single clickable emoji
 */
const EmojiButton = ({emoji, onSelect}) => {
  const handleMouseDown = (event) => {
    onSelect(event, emoji);
  };

  return (
    <span
      className="emoji-selector-option"
      onMouseDown={handleMouseDown}
    >
      {emoji}
    </span>
  );
};

EmojiButton.propTypes = {
  emoji: PropTypes.string.isRequired,
  onSelect: PropTypes.func.isRequired,
};

export default EmojiButton;
