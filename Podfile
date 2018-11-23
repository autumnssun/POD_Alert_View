# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
def testPod
    pod 'Quick'
    pod 'Nimble'
end
def shared
    pod 'SnapKit'
    pod 'Material'
    pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :branch => 'master'
end

target 'NN_Alert' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    shared
    # Pods for NN_Alert
    
end

target 'NN_Alert_Demo' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    shared
    pod 'IQKeyboardManager'

end

target 'NN_Alert_Unit_Tests' do
    use_frameworks!
    testPod
end
