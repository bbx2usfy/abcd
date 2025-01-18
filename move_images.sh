#!/bin/bash

# 定义Source和Target的目录路径
source_dir="/home/GAKER/GAKer-main/Source images dataset"
target_dir="/home/GAKER/GAKer-main/Target images dataset"

# 遍历Source目录中的文件夹
for source_folder in "$source_dir"/*; do
    # 只处理文件夹
    if [ -d "$source_folder" ]; then
        folder_name=$(basename "$source_folder")
        target_folder="$target_dir/$folder_name"
        
        # 检查Source文件夹是否为空
        if [ -z "$(find "$source_folder" -mindepth 1 -print -quit)" ]; then
            echo "$source_folder is empty."

            # 检查Target文件夹是否存在，并且其中是否有图片
            if [ -d "$target_folder" ] && [ "$(find "$target_folder" -mindepth 1 -print -quit)" ]; then
                echo "Moving images from $target_folder to $source_folder"
                
                # 获取Target文件夹中的前10张图片
                count=0
                for img in "$target_folder"/*.{jpg,jpeg,png,bmp,tiff,webp,JPEG};do
		    if [ -f "$img" ]; then
                        if [ $count -lt 10 ]; then
                            # 移动图片
                            mv "$img" "$source_folder/"
                            ((count++))
                            echo "Moved $img"
                        else
                            break
                        fi
                    fi
                done
            fi
        fi
    fi
done
