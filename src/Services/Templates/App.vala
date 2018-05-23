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
using Alcadica.Entities.Template;
using Alcadica.Services;

namespace Alcadica.Services.Templates { 
	public class App : TemplateService { 

		public unowned string appdata_xml = "appdata.xml.in";
		public unowned string desktop_entry = "desktop.in";
		
		public App (string base_dir) {
			Object(base_dir: base_dir, template_name: "app");
		}
		
		protected override void on_init () {
			this.add_file (".editorconfig", get_content_from_shared_file (".editorconfig"));
			this.add_file ("config.vala", get_content_from_shared_file ("config.vala"));
			this.add_file ("data/" + this.appdata_xml, get_content_from_shared_file ("data/appdata.xml"));
			this.add_file ("data/" + this.desktop_entry, get_content_from_shared_file ("data/desktop"));
			this.add_file ("data/icons/128/name.svg", get_content_from_shared_file ("data/icons/128/name.svg"));
			this.add_file ("data/icons/256/name.svg", get_content_from_shared_file ("data/icons/256/name.svg"));
			this.add_file ("data/icons/name.svg", get_content_from_shared_file ("data/icons/name.svg"));
			this.add_file ("debian/source/format", get_content_from_shared_file ("debian/source/format"));
			this.add_file ("debian/changelog", get_content_from_shared_file ("debian/changelog"));
			this.add_file ("debian/compat", get_content_from_shared_file ("debian/compat"));
			this.add_file ("debian/control", get_content_from_shared_file ("debian/control"));
			this.add_file ("debian/copyright", get_content_from_shared_file ("debian/copyright"));
			this.add_file ("debian/rules", get_content_from_shared_file ("debian/rules"));
			this.add_file ("meson.build", get_content_from_shared_file ("meson.build"));
			this.add_file ("src/Application.vala", get_content_from_shared_file ("src/Application.vala"));
		}

		protected override void on_directory_write_end (TemplateFile directory) { }

		protected override void on_file_write_end (TemplateFile file) {
			File _file = File.new_for_path (file.path);
			string basename = _file.get_basename ();

			if (basename == this.appdata_xml) {
				string destination = this.root_dir_name + ".appdata.xml.in";
				debug ("\nRenaming appdata file to: " + destination);
				FileSystem.rename (_file, destination);
			} else if (basename == this.desktop_entry) {
				string destination = this.root_dir_name + ".desktop.in.in";
				debug ("\nRenaming desktop file to: " + destination);
				FileSystem.rename (_file, destination);
			} else if (basename == "name.svg") {
				string destination = this.root_dir_name + ".svg";
				debug ("\nRenaming icon file to: " + destination);
				FileSystem.rename (_file, destination);
			}
		}
	}
}