using ModelicaScriptingTools
using Test
using OMJulia: sendExpression

refdir = "subprojects/shm-ref"
# only simulate full models for two seconds in order to reduce execution time
# of tests and size of reference data files
twosec = Dict("stopTime" => 2, "numberOfIntervals" => 2000)

withOMC("test-output", ".") do omc
    sendExpression(omc, "setCommandLineOptions(\"-d=newInst,nfAPI\")")
    installAndLoad(omc, "Modelica"; version="3.2.3")
    @testset "Simulations" begin
        @testset "Kotani2005" begin
            #testmodel(omc, "SHM.Kotani2005.Examples.FullModel.KotaniFullExample"; refdir=refdir, override=twosec)
        end
        @testset "SeidelThesis" begin
            #testmodel(omc, "SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample"; refdir=refdir, override=twosec)
        end
        @testset "SchoelzelThesis" begin
            @testset "AVDelayExample" begin
                installAndLoad(omc, "SHMConduction") # SHMConduction is required for AVDelayExample
                testmodel(omc, "SHM.SchoelzelThesis.Examples.AVDelayExample"; refdir=refdir)
            end
            @testset "MultiDelayExample" begin
                testmodel(omc, "SHM.SchoelzelThesis.Examples.MultiDelayExample"; refdir=refdir)
            end
            @testset "PacemakerExample" begin
                testmodel(omc, "SHM.SchoelzelThesis.Examples.PacemakerExample"; refdir=refdir)
            end
            @testset "RefractoryDelayExample" begin
                testmodel(omc, "SHM.SchoelzelThesis.Examples.RefractoryDelayExample"; refdir=refdir)
            end
            @testset "RefractoryExample" begin
                testmodel(omc, "SHM.SchoelzelThesis.Examples.RefractoryExample"; refdir=refdir)
            end
            @testset "UnidirectionalModularExample" begin
                testmodel(omc, "SHM.SchoelzelThesis.Examples.UnidirectionalModularExample"; refdir=refdir)
            end
            @testset "BidirectionalContractionExample" begin
                testmodel(omc, "SHM.SchoelzelThesis.Examples.BidirectionalContractionExample"; refdir=refdir)
            end
            @testset "BidirectionalContractionMixinExample" begin
                testmodel(omc, "SHM.SchoelzelThesis.Examples.BidirectionalContractionMixinExample"; refdir=refdir)
            end
        end
        @testset "shm-conduction" begin
            #testmodel(omc, "SHMConduction.Examples.ModularExample"; refdir=refdir)
        end
    end
end
