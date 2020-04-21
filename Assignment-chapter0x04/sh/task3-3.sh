 #!/usr/bin/env bash

 Help(){
	   printf "usage: ./task3-3.sh <filename>[arguments]\n\n"
	     printf "Arguments:\n"
	       printf " -sourcehost \t\t 统计访问来源主机TOP 100和分别对应出现的总次数\n"
	         printf " -sourceip \t\t 统计访问来源主机TOP 100 IP和分别对应出现的总次数\n"
		   printf " -fre \t\t 统计最频繁被访问的URL TOP 100\n"
		     printf " -sta \t\t 统计不同响应状态码的出现次数和对应百分比\n"
		       printf " -sta4x \t\t 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数\n"
		         printf " -urhost \t\t 给定URL输出TOP 100访问来源主机\n"
		 }

		 SourceHost(){
			   filename="${1}"
			     printf "\n[----------访问来源主机TOP 100和分别对应出现的总次数----------]\n"
			       result=$( awk 'BEGIN{FS="\t"} $1 ~ /^(\w+\.)+[a-zA-Z]/ {print $1}' "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source host: %-35s\t Number: %d\n",$2,$1)}')
			         echo "${result}"

				   return 0
			   }

			   SourceIp(){
				     filename="${1}"
				       printf "\n[-----------访问来源主机TOP 100 IP和分别对应出现的总次数----------]\n"
				         result=$(awk 'BEGIN{FS="\t"} $1 ~ /([0-9]{1,3}\.){3}[0-9]{1,3}/ {print $1}' "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source IP: %-15s\t Number: %d\n",$2,$1)}')
					   echo "${result}"

					     return 0
				     }

				     freUrl(){
					       filename="${1}"
					         printf "\n[----------最频繁被访问的URL TOP 100----------]\n"
						   result=$(awk 'BEGIN{FS="\t"} $5 != "/" {print $5}' "${filename}" | sort | uniq -c | sort -nr | head -n 100)
						     echo "${result}"

						       return 0
					       }

					       DifStatus(){
						         filename="${1}"
							   printf "\n[---------不同响应状态码的出现次数和对应百分比----------]\n"
							     sum=$(awk 'BEGIN{FS="\t";sum=0} $6 ~ /[0~9]/ {sum=sum+1} END {print sum}' "${filename}")
							       result=$(awk 'BEGIN{FS="\t"} $6 ~ /[0~9]/{print $6}' "${filename}" | sort | uniq -c | sort -nr | awk 'BEGIN{FS=" "} {printf("Status code: %-10s\t Number: %-20d\t Percentage:%-4.5f%%\n",$2,$1,100*$1/'"${sum}"')}')
							         echo "${result}"

								   return 0
							   }

							   Status4x(){
								     filename="${filename}"

								       printf "\n[----------不同4XX状态码对应的TOP 10 URL和对应出现的总次数-----------]\n"

								         codes=$(awk 'BEGIN{FS="\t"} $6 ~ /[4][0-9][0-9]/ {print $6}' "${filename}" | sort -u )

									   echo "${codes}"

									     for key in $codes
										       do
											           printf "Status code: %10s\n" "${key}"
												       result=$(awk 'BEGIN{FS="\t"} $6=='"${key}"' {print $5}' "${filename}" | sort | uniq -c | sort -nr | head -n 10 )
												           echo "${result}"
													     done

													       return 0
												       } 

												       StatusHost(){
													         filename="${1}"
														   url="${2}"

														     printf "Input URL: %-10s\n" "${url}"
														       result=$(awk 'BEGIN{FS="\t"} $5==ur {print $1} ' ur="${url}" "${filename}" | sort | uniq -c | sort -nr | head -n 100 | awk 'BEGIN{FS=" "} {printf("Source host: %-20s\t Number: %d\n",$2,$1)}')
														         echo "${result}"

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
																			         -sourcehost)
																					       SourceHost "${filename}"
																					             ;;
																						         -sourceip)
																								       SourceIp "${filename}"
																								             ;;
																									         -fre)
																											       freUrl "${filename}"
																											             ;;
																												         -sta)
																														       DifStatus "${filename}"
																														             ;;
																															         -sta4x)
																																	       Status4x "${filename}"
																																	             ;;
																																		         -urhost)
																																				       url="${2}"
																																				             StatusHost "${filename}" "${url}"
																																					           shift
																																						         ;;
																																							     *)
																																								           echo "ERROR:${1} is not a option"
																																									         ;;
																																										   esac
																																										     shift
																																									     done
