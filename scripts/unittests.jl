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
            testmodel(omc, "SHM.Kotani2005.Examples.FullModel.KotaniFullExample"; refdir=refdir, override=twosec)
        end
        @testset "SeidelThesis" begin
            testmodel(omc, "SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample"; refdir=refdir, override=twosec)
        end
        @testset "SchoelzelThesis" begin
            testmodel(omc, "SHM.SchoelzelThesis.Examples.UnidirectionalModularExample"; refdir=refdir)
            testmodel(omc, "SHM.SchoelzelThesis.Examples.BidirectionalContractionExample"; refdir=refdir)
            testmodel(omc, "SHM.SchoelzelThesis.Examples.BidirectionalContractionMixinExample"; refdir=refdir)
        end
        @testset "shm-conduction" begin
            testmodel(omc, "SHMConduction.Examples.ModularExample"; refdir=refdir)
        end
    end
end
