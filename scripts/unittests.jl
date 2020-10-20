using ModelicaScriptingTools
using Test

refdir = "refData"

withOMC("test-output", ".") do omc
    @testset "Simulations" begin
        @testset "Kotani2005" begin
            testmodel(omc, "SHM.Kotani2005.Examples.FullModel.KotaniFullExample"; refdir=refdir, override=Dict("stopTime" => "10"))
        end
        @testset "SeidelThesis" begin
            testmodel(omc, "SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample"; refdir=refdir)
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
