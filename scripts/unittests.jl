using ModelicaScriptingTools
using Test

refdir = nothing

withOMC("test-output", ".") do omc
    @testset "Kotani2005" begin
        testmodel(omc, "SHM.Kotani2005.Examples.FullModel.KotaniFullExample"; refdir=refdir)
    end
    @testset "SeidelThesis" begin
        testmodel(omc, "SHM.SeidelThesis.Examples.FullModel.SeidelThesisFullExample"; refdir=refdir)
    end
    @testset "SchoelzelThesis" begin
        testmodel(omc, "SHM.SchoelzelThesis.Examples.UnidirectionalModularExample"; refdir=refdir)
        testmodel(omc, "SHM.SchoelzelThesis.Examples.BidirectionalContractionExample"; refdir=refdir)
        testmodel(omc, "SHM.SchoelzelThesis.Examples.BidirectionalContractionMixinExample"; refdir=refdir)
    end
end
