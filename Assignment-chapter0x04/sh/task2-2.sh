 #!/usr/bin/env bash


 printAll(){
	   filename="${1}"
	     Age "${filename}"
	       Position "${filename}"
	         Name "${filename}"

		   return 0
	   }
	   Help(){
		     printf "usage: ./Task_2.sh <filename>[arguments]\n\n"
		       printf "Arguments:\n"
		         printf " -all \t\t 显示所有统计信息\n"
			   printf " -age \t\t 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比\n"
			     printf " -position\t\t 统计不同场上位置的球员数量、百分比\n"
			       printf " -name \t\t 名字最长的球员和名字最短的球员\n"
			         printf " -h \t\t 显示帮助信息\n"
			 }

			 Age(){

				   filename="${1}"

				     twenty=$(awk ' BEGIN{FS="\t"} $6<20 && NR != 1 {print $6}' "${filename}"|wc -l)

				       twentytothrity=$(awk ' BEGIN{FS="\t"} $6>=20 && $6 <= 30 && NR != 1 {print $6}' "${filename}"|wc -l)

				         thrity=$(awk ' BEGIN{FS="\t"} $6>30 && NR != 1 {print $6}' "${filename}"|wc -l)

					   total=$( wc -l < "${filename}")
					     total=$(( total - 1))
					       printf "\n[------------年龄信息------------]\n"
					         printf "20岁以下球员数量:%4d people\n" "${twenty}"
						   val=$(echo "scale=2;100*$twenty/$total"|bc)
						     printf "百分比:%4.2f%%\n" "${val}"
						       printf "20-30岁的球员数量\n" "${twentytothrity}"
						         val=$(echo "scale=2;100*$twentytothrity/$total"|bc)
							   printf "百分比:%4.2f%%\n" "${val}"
							     printf "30岁以上球员数量:%4d people\n" "${thrity}"
							       val=$(echo "scale=2;100*$thrity/$total"|bc)
							         printf "百分比:%4.2f%%\n\n" "${val}"
								   printf "\n[----------年龄最大球员----------]\n"
								     
								     age=$(awk ' BEGIN {FS="\t";maxage=0} NR!=1 {if($6>maxage) {maxage=$6}} END {print maxage}' "${filename}")
								       printf "Age:%d\n" "${age}"
								         oldest=$(awk ' BEGIN {FS="\t"} NR!=1 {if($6=='"${age}"') {print $9}}' "${filename}")
									   echo "${oldest}"
									     printf "\n[----------最年轻的球员----------]\n"

									       age=$(awk ' BEGIN {FS="\t";minage=100} NR!=1 {if($6<minage) {minage=$6}} END {print minage}' "${filename}")
									         printf "Age:%d\n" "${age}"
										   youngest=$(awk ' BEGIN {FS="\t"} NR!=1 {if($6=='"${age}"') {print $9}}' "${filename}")
										     echo "${youngest}"

										       return 0

									       }

									       Position(){
										         filename="${1}"

											   total=$( wc -l < "${filename}")
											     total=$(( total - 1))

											       printf "\n[----------球员位置信息----------]\n"
											         position=$(awk ' BEGIN {FS="\t"} NR!=1 {if ($5=="Défenseur") {print "Defender"} else {print $5} }' "${filename}" | sort -f | uniq -c )
												   test=$(echo "${position}" | awk '{printf("位置:%-10s\tNumber:%d\t百分比:%4.2f%%\n",$2,$1,100*$1/'"${total}"')}')
												     echo "${test}" 

												       return 0
											       }

											       Name(){
												         filename="${1}"

													   printf "\n[----------名字最长球员----------]\n"

													     leng=$(awk ' BEGIN {FS="\t";lolen=0} NR!=1 {if(length($9)>lolen) {lolen=length($9)}} END {print lolen}' "${filename}")
													       printf "名字长度:%d\n" "${leng}"
													         longest=$(awk ' BEGIN {FS="\t"} NR!=1 {if(length($9)=='"${leng}"') {print $9}}' "${filename}")
														   echo "${longest}"

														     printf "\n[----------名字最短球员----------]\n"

														       leng=$(awk ' BEGIN {FS="\t";shlen=1000} NR!=1 {if(length($9)<shlen) {shlen=length($9)}} END {print shlen}' "${filename}")
														         printf "名字长度:%d\n" "${leng}"
															   shortest=$(awk ' BEGIN {FS="\t"} NR!=1 {if(length($9)=='"${leng}"') {print $9}}' "${filename}")
															     echo "${shortest}"

															       return 0
														       }

														       filename=${1}
														       shift
														       while [ -n "${1}" ]
														       do
															         case "${1}" in 

																	     -h|--help)
																		           Help
																			         ;;
																				     -all)
																					           printAll "${filename}"
																						         ;;
																							     -age)
																								           Age "${filename}"
																									         ;;
																										     -position)
																											           Position "${filename}"
																												         ;;
																													     -name)
																														           Name "${filename}"
																															         ;;
																																     *)
																																	           echo "ERROR:${1} is not an option"
																																		         ;;
																																			   esac
																																			     shift
																																		     done

