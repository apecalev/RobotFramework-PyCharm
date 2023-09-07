pipeline {
  agent {label 'qaslave1'}
  parameters {
	choice(choices: ['qa1', 'qa2', 'prod'], description: 'Select on which envrironment the scripts would run', name: 'environment')
  }    
  stages {
    stage('Clean Workspace') {
      steps {
        dir ("Generic") {
            deleteDir()
        }
      }
    }
    stage('Checkout Code') {
        steps {
            checkout scm
        }
    }
    stage('Execute Tests') {
		parallel {
			stage('Homepage') {
				steps {
					script{
						try {
						bat """call python -m robot -v env:${params.environment} -v browser:chrome -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output homepage_1.xml --RemoveKeywords WUKS Generic/TestCases/REG_Homepage.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('Account') {
				steps {
					script{
						try {
						bat """call python -m robot -v env:${params.environment} -v browser:chrome -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output account_1.xml --RemoveKeywords WUKS Generic/TestCases/REG_Account.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('Cart') {
				steps {
					script{
						try {
						bat """robot -v env:${params.environment} -v browser:chrome -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output cart_1.xml --RemoveKeywords WUKS Generic/TestCases/REG_Cart.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('PLP') {
				steps {
					script{
						try {
						bat """call python -m robot -v env:${params.environment} -v browser:chrome -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output plp_1.xml --RemoveKeywords WUKS Generic/TestCases/REG_PLP.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('PDP') {
				steps {
					script{
						try {
						bat """call python -m robot -v env:${params.environment} -v browser:chrome -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output pdp_1.xml --RemoveKeywords WUKS Generic/TestCases/REG_PDP.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
		}
    }
	stage('Delete Obsolete Screenshots') { 
		steps {
			script{
				try {
					bat 'del Generic\\Results\\*.png'
				}catch(err){
					echo err.toString()
				}
				currentBuild.result = "SUCCESS"
			}
		}
	}
	stage('Rerun Failed Tests') {
		parallel {
			stage('Homepage') {
				steps {
					script{
						try {
						bat """call python -m robot -v env:${params.environment} -v browser:chrome  --rerunfailed Generic/Results/homepage_1.xml --RunEmptySuite -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output homepage_2.xml --RemoveKeywords WUKS Generic/TestCases/REG_Homepage.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('Cart') {
				steps {
					script{
						try {
						bat """robot -v env:${params.environment} -v browser:chrome  --rerunfailed Generic/Results/cart_1.xml --RunEmptySuite -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output cart_2.xml --RemoveKeywords WUKS Generic/TestCases/REG_Cart.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('Account') {
				steps {
					script{
						try {
						bat """robot -v env:${params.environment} -v browser:chrome  --rerunfailed Generic/Results/account_1.xml --RunEmptySuite -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output account_2.xml --RemoveKeywords WUKS Generic/TestCases/REG_Account.robot"""
								}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('PLP') {
				steps {
					script{
						try {
						bat """call python -m robot -v env:${params.environment} -v browser:chrome  --rerunfailed Generic/Results/plp_1.xml --RunEmptySuite -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output plp_2.xml --RemoveKeywords WUKS Generic/TestCases/REG_PLP.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('PDP') {
				steps {
					script{
						try {
						bat """call python -m robot -v env:${params.environment} -v browser:chrome  --rerunfailed Generic/Results/pdp_1.xml --RunEmptySuite -i regression --RemoveKeywords WUKS -d Generic/Results --log NONE --report NONE --output pdp_2.xml --RemoveKeywords WUKS Generic/TestCases/REG_PDP.robot"""
							}
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
		}
    }
	stage('Merge Result Files') {
		parallel {
			stage('Homepage') {
				steps {
					script{
						try {
							bat 'call rebot --ProcessEmptySuite --log NONE --report NONE --output Generic/Results/homepage.xml --merge Generic/Results/homepage_*.xml'
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('Cart') {
				steps {
					script{
						try {
							bat 'call rebot --ProcessEmptySuite --log NONE --report NONE --output Generic/Results/cart.xml --merge Generic/Results/cart_*.xml'
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('Account') {
				steps {
					script{
						try {
							bat 'call rebot --ProcessEmptySuite --log NONE --report NONE --output Generic/Results/account.xml --merge Generic/Results/account_*.xml'
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('PLP') {
				steps {
					script{
						try {
							bat 'call rebot --ProcessEmptySuite --log NONE --report NONE --output Generic/Results/plp.xml --merge Generic/Results/plp_*.xml'
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
			stage('PDP') {
				steps {
					script{
						try {
							bat 'call rebot --ProcessEmptySuite --log NONE --report NONE --output Generic/Results/pdp.xml --merge Generic/Results/pdp_*.xml'
						}catch(err){
							echo err.toString()
						}
						currentBuild.result = "SUCCESS"
					}
				}
			}
		}
	}
	stage('Collect Results') {
		steps {
			script{
				try{
					bat """call rebot --name Generic_${params.environment}_regression_suites --RemoveKeywords WUKS --output Generic/Results/regression.xml --log Generic/Results/log.html --report Generic/Results/report.html Generic/Results/homepage.xml Generic/Results/cart.xml Generic/Results/account.xml Generic/Results/pdp.xml Generic/Results/plp.xml"""
				}catch(err){
					echo err.toString()
				}
				currentBuild.result = "SUCCESS"
				zip zipFile: 'Generic/Results/results.zip', archive: false, dir: 'Generic/Results', glob: '*.html, *.png, regression.xml'
				step(
					[
					  $class              : 'RobotPublisher',
					  outputPath          : 'Generic/Results',
					  outputFileName      : 'regression.xml',
					  reportFileName      : 'report.html',
					  logFileName         : 'log.html',
					  disableArchiveOutput: false,
					  passThreshold       : 100.0,
					  unstableThreshold   : 90.0,
					  otherFiles          : "**/*.png,**/*.jpg",
					]
				)
			}
		}
	}
	stage('Send email') {
		steps {
			emailext body: "Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} : ${currentBuild.currentResult}\n More info at: ${env.BUILD_URL}robot", subject: "[AUTOMATION] Generic QA regression results", to: 'stefan.sandovski@iwconnect.com, cc:stefan.mandovski@interworks.com.mk', attachmentsPattern: 'Generic/Results/*.zip'
		}
	}
  }
  post {
        always {
            archiveArtifacts 'Generic/Results/*.html, Generic/Results/regression.xml'
        }
    }
}
