/*******************************************************************************
* This file is a part of Gitolite-Repository-Creator project
* Maintained by : Varuna Lekamwasam <vrlekamwasam@gmail.com>
* Authored By : Varuna Lekamwasam <vrlekamwasam@gmail.com>
*
* Gitolite-Repository-Creator is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* Gitolite-Repository-Creator is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU Lesser General Public License for more details.
*
* For the GNU General Public License see <http://www.gnu.org/licenses/lgpl.html>
*******************************************************************************/

File list :
	Gitolite-Repository-Creator -> README.txt
	Gitolite-Repository-Creator -> gitolite-repo-setup.sh

Usage :
	./gitolite-repo-setup.sh <KEY_COLLECTION_FOLDER> <GITOLITE_ADMIN_REPOSITORY_CLONE>

<KEY_COLLECTION_FOLDER> : Create a folder containing all the SSH public keys that you need to add to the repository,
			  and name the folder with the repository name that you need.
			  Provide the parent folder of the repository folder that you created to the script.

			  Example : key_collection_folder/repository_name_folder/user_name1_key.pub
				    key_collection_folder/repository_name_folder/user_name2_key.pub

<GITOLITE_ADMIN_REPOSITORY_CLONE> : The script does not know anything about the clone of the admin_repository. Or either 
				    its the Gitolite_admin repository. The script only checks if the folder given is a
				    git version controlled folder. Make sure that you specify the correct folder.

//TODO: There is a error reported by the script saying command not found while commiting the work. Ignore this.
	Still trying to figure out why its there.. :)
