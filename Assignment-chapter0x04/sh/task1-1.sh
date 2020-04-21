#!/usr/bin/env bash

# 帮助函数
Help(){

	  printf "usage: ./task1-1.sh [filename][arguments]\n\n"
	    printf "Arguments:\n"
	      printf "  -f <filename>\t 选择一个文件\n"
	        printf "  -c <Size> <Width> <Height> <quality>\t 支持对jpeg格式图片进行图片质量压缩\n"
		  printf "  -cr <resolution>\t 支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率\n"
		    printf "  -w <watermarks> \t 支持对图片批量添加自定义文本水印\n"
		      printf "  -b <-p|-s> <text> <imagetype> \t 支持批量重命名\n"
		        printf "  -tr \t 支持将png/svg图片统一转换为jpg格式图片\n"

			  return 0

		  }

		  # 对JPEG图像进行处理
		  # 文件名或者文件路径
		  # Size 图片尺寸允许值
		  # Width 图片最大宽度
		  # Height 图片最大高度
		  # quality 图片质量
		  Compress(){
			    path=${1}
			      Size=${2}
			        Width=${3}
				  Height=${4}
				    quality=${5}
				      if [ -d "${path}" ]
					        then
							    files=$(find "${path}" \( -name "*.jpg" \) -type f -size +"${Size}" -exec ls {} \;);
							        for file in ${files}
									    do
										          echo "${file}"
											         convert -resize "${Width}"x"${Height}" "${file}" -quality "${quality}" "${file}"
												     done
												       elif [ -f "${path}" ]
													         then
															     echo "${path}"
															         convert -resize "${Width}"x"${Height}" "${path}" -quality "${quality}" "${path}"
																   fi

																     return 0
															     }

															     # 支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
															     compression(){
																       path=${1}
																         resolution=${2}
																	   if [ -d "${path}" ]
																		     then
																			         files=$(find "${path}" \( -name "*.jpg" -or -name "*.png" -or -name "*.svg" \) -type f -exec ls {} \;);
																				     for file in ${files}
																					         do
																							       echo "${file}"
																							             # info=$(identify "${file}")
																								           # resolution=$(echo "${info}" | awk '{split($0,a," ");print a[3]}')
																									         convert -resize "${resolution}" "${file}" "${file}"
																										     done
																										       elif [ -f "${path}" ]
																											         then
																													     echo "${path}"
																													         # info=$(identify "${path}")
																														     # resolution=$(echo "${info}" | awk '{split($0,a," ");print a[3]}')
																														         convert -resize "${resolution}" "${path}" "${path}"
																															   fi

																															     return 0
																														     }
                                                                                                                                #支持对图片批量添加自定义文本水印
																														        Watermark(){
																															       path=${1}
																															         watermark=${2}

																																   if [ -d "${path}" ]
																																	     then
																																		         files=$(find "${path}" \( -name "*.jpg" -or -name "*.png" -or -name "*.svg" -or -name ".bmp" -or -name ".svg" \) -type f -exec ls {} \;);

																																			     for file in ${files}
																																				         do
																																						       echo "${file}"
																																						             echo "watermark: ${watermark} "
																																							           convert ${file} -gravity southeast -fill black -pointsize 32 -draw " text 5,5 ${watermark} " "${file}"
																																								       done

																																								         elif [ -f "${path}" ]
																																										   then
																																											       echo "${path}"
																																											           echo "watermark: ${watermark} "
																																												       convert ${path} -gravity southeast -fill black -pointsize 64 -draw "text 5,5 ${watermark} " "${path}"
																																												         fi

																																													   return 0
																																												   }
                                                                                                                                                                                   #添加后缀            
																																												   Suffix(){
																																													     path="${1}"
																																													       text="s/\.""${3}""$/""${2}"".""${3}""/"
																																													         imagetype="*.""${3}"
																																														   if [ -d "${path}" ]
																																															     then
																																																         echo "${path}"
																																																	     cd "${path}" || return 1
																																																	         rename "${text}" ${imagetype}
																																																		     cd ..
																																																		       elif [ -f "${path}" ]
																																																			         then
																																																					     echo "${path}"
																																																					         cd "${path%/*}" || return 1
																																																						     rename "${text}" ${path##*/}
																																																						         cd ..
																																																							   fi

																																																							     return 0

																																																						     }
                                                                                                                                                                                                                               #添加前缀          
																																																						        Prefix(){
																																																							       path="${1}"
																																																							         text="s/^/""${2}""/"
																																																								   imagetype="*.""${3}"
																																																								     if [ -d "${path}" ]
																																																									       then
																																																										           echo "${path}"
																																																											       cd "${path}" || return 1
																																																											           rename "${text}" ${imagetype}
																																																												       cd ..
																																																												         elif [ -f "${path}" ]
																																																														   then
																																																															       echo "${path}"
																																																															           cd "${path%/*}" || return 1
																																																																       mv "${path##*/}" "${2}""${path##*/}"
																																																																           cd ..
																																																																	     fi

																																																																	       return 0
																																																																       }

																																																																       # 支持将png/svg图片转换为jpg
																																																																       trantoJpg(){
																																																																	         path="${1}"
																																																																		   if [ -d "${path}" ]
																																																																			     then
																																																																				         files=$(find "${path}" \( -name "*.png" -or -name "*.svg" \) -type f -exec ls {} \;);
																																																																					     for file in ${files}
																																																																						         do
																																																																								       file="${file##*/}"
																																																																								             echo "${file}"
																																																																									           cd "${path%/*}" || return 1
																																																																										         convert "${file}" "${file%.*}"".jpg"
																																																																											       cd ..
																																																																											           done
																																																																												     elif [ -f "${path}" ]
																																																																													       then
																																																																														           if [ "${path##*.}" == "svg" ] || [ "${path##*.}" == "png" ]
																																																																																       then
																																																																																	             file="${path##*/}"
																																																																																		           echo "${file}"
																																																																																			         cd "${path%/*}" || return 1
																																																																																				       convert "${file}" "${file%.*}.jpg"
																																																																																				             cd ..
																																																																																					         fi
																																																																																						   fi

																																																																																						     return 0
																																																																																					     }

																																																																																					     while [ -n "${1}" ]
																																																																																					     do
																																																																																						       case "${1}" in

																																																																																							           -h|--help)
																																																																																									         Help
																																																																																										       ;;
																																																																																										           
																																																																																										           -f)
																																																																																												         if [ "${#}" == 1 ]
																																																																																														       then
																																																																																															               echo "Error: You must description of the file or folder to manipulate"
																																																																																																               exit 0 
																																																																																																	             elif [ ! -d "${2}" ] && [ ! -f "${2}" ]
																																																																																																			           then
																																																																																																					           echo "Error: The directory or file dose not exist"
																																																																																																						           exit 0
																																																																																																							         fi
																																																																																																								       path="${2}"
																																																																																																								             echo "选择的文件夹为:${2}"
																																																																																																									           shift
																																																																																																										         ;;

																																																																																																											     -c)
																																																																																																												           Size=${2}
																																																																																																													         Width=${3}
																																																																																																														       Height=${4}
																																																																																																														             quality=${5}
																																																																																																															           Compress "${path}" "${Size}" "${Width}" "${Height}" "${quality}"
																																																																																																																         shift
																																																																																																																	       shift
																																																																																																																	             shift
																																																																																																																		           shift
																																																																																																																			         ;;
																																																																																																																				     -cr)
																																																																																																																					           resolution=${2}
																																																																																																																						         compression "${path}" "${resolution}"
																																																																																																																							       shift
																																																																																																																							             ;;
																																																																																																																								         -w)
																																																																																																																										       watermark=${2}
																																																																																																																										             Watermark "${path}" "${watermark}"
																																																																																																																											           shift
																																																																																																																												         ;;
																																																																																																																													     -b)
																																																																																																																														           position=${2}
																																																																																																																															         text=${3}
																																																																																																																																       imagetype=${4}
																																																																																																																																             if [ "${position}" == "-p" ]
																																																																																																																																		           then
																																																																																																																																				           Prefix "${path}" "${text}" "${imagetype}"
																																																																																																																																					         elif [ "${position}" == "-s" ]
																																																																																																																																							       then
																																																																																																																																								               Suffix "${path}" "${text}" "${imagetype}"
																																																																																																																																									             else
																																																																																																																																											             echo "Error: There is a problem with the input parameters,you can choose the -p (prefix) or -s(suffix)"
																																																																																																																																												           fi
																																																																																																																																													         shift
																																																																																																																																														       shift
																																																																																																																																														             shift
																																																																																																																																															           ;;
																																																																																																																																																       -tr)
																																																																																																																																																	             trantoJpg "${path}"
																																																																																																																																																		           ;;
																																																																																																																																																			       *)
																																																																																																																																																				             echo "Error: ${1} is not an option"
																																																																																																																																																					           ;;
																																																																																																																																																						     esac
																																																																																																																																																						       shift
																																																																																																																																																					       done
