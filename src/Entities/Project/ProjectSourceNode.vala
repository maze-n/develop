/*
* Copyright (c) 2011-2018 alcadica (https://www.alcadica.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: alcadica <github@alcadica.com>
*/
namespace Alcadica.Entities.Project {
	public class ProjectSourceNode { 
		public static Node<ProjectItem>? build_from_filepath (string path) {
			Node<ProjectItem>? previous = null;
			Node<ProjectItem>? node = null;
			string[] chunks = path.split(Path.DIR_SEPARATOR.to_string ());

			if (chunks.length == 0) {
				return node;
			}

			foreach (var chunk in chunks) {
				ProjectItem data;
				
				if (chunk.index_of (".vala") > 0) {
					data = new ProjectItemSource ();
				} else {
					data = new ProjectItemDirectory ();
				}

				data.filename = chunk;
				
				Node<ProjectItem> _node = new Node<ProjectItem> (data);
				
				if (previous == null) {
					previous = _node.copy ();
					continue;
				} else {
					previous.append (_node.copy ());
				}
			}

			return node;
		}

		public static Node<ProjectItem> build_from_files_list (List<string> list) {
			Node<ProjectItem> root = new Node<ProjectItem> ();

			return root;
		}
	}
}